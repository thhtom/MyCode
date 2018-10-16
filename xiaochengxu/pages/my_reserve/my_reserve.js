// pages/my_reserve/my_reserve.js
var pageCount = 1;
var allCount = 0;
var count = 0;
var dataAry = [];

Page({

  /**
   * 页面的初始数据
   */
  data: { 
    list:[],
    show:"block",
  },

  load() {
    var that = this;
    function model(time, statusImg, statusTitle, img, title, city, status, id, show, height, leftShow, leftTitle, rightTitle, rightShow, reserve_number, right, index) {
      this.time = time;
      this.statusImg = statusImg;
      this.statusTitle = statusTitle;
      this.img = img;
      this.title = title;
      this.city = city;
      this.id = id;
      this.show = show;
      this.height = height;
      this.leftShow = leftShow;
      this.leftTitle = leftTitle;
      this.rightTitle = rightTitle;
      this.rightShow = rightShow;
      this.reserve_number = reserve_number;
      this.right = right;
      this.index = index;
    }

    var network = require("../../utils/network.js")
    var params = new Object()
    params.page = pageCount;
    var user_id = "";
    try{
      user_id = wx.getStorageSync(getApp().globalData.USER_ID);
    }catch(e){
      user_id = "";
    }
    if (user_id.length>0){
        params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
        network.requestLoading(getApp().globalData.API_URL + "/Home/Reservation/getReservation", params, '正在加载数据', function (res) {
          console.log(res);

          //刷新状态
          wx.stopPullDownRefresh()
          wx.hideNavigationBarLoading()
          allCount = res.data.count;
          count = count+res.data.info.length;

          //保存最新的证件状态
          wx.setStorageSync(getApp().globalData.AUTHENT, res.data.is_authentication);

          if (res.status == 1) {
            var tempAry = []
            var leftShow = "none"
            var leftTitle = ""
            var rightTitle = "取消预约"
            var rightShow = "block"
            var authent = wx.getStorageSync(getApp().globalData.AUTHENT)
            var right = 210
            
            for (var i = 0; i < res.data.info.length; i++) {
              var statusTitle = "";
              var img = "";
              var show = "block";
              var height = 398;
              
              if (authent == 2){
                leftShow = "block"
                leftTitle = "重新提交"
                statusTitle = "已驳回";
                img = "../../image/reserve_cancel.png";
                rightTitle = "查看原因"
              }else{
                if (authent == 0) {
                  leftShow = "block"
                  leftTitle = "提交资料"
                }
                //状态(0:预约中,1:邀请中,2:已体验,3:已取消,4:未通过,5:已下单,6:已过期，8:预约中)
                if (res.data.info[i].status == 0) {
                  statusTitle = "预约中";
                  img = "../../image/reserve_reserving.png";
                } else if (res.data.info[i].status == 1) {
                  statusTitle = "已邀请";
                  img = "../../image/reserve_invite.png";
                  show = "none";
                  height = 307;
                } else if (res.data.info[i].status == 2) {
                  statusTitle = "已体验";
                  img = "../../image/reserve_complete.png";
                  show = "none";
                  height = 307;
                } else if (res.data.info[i].status == 3) {
                  statusTitle = "已取消";
                  img = "../../image/reserve_cancel.png";
                  // show = "none";
                  // height = 307;
                  leftShow = "none";
                  rightTitle = "删除";

                } else if (res.data.info[i].status == 4) {
                  statusTitle = "已驳回";
                  img = "../../image/reserve_cancel.png";
                  right = 25;
                  rightShow = "none"
                } else if (res.data.info[i].status == 5) {
                  statusTitle = "已下单";
                  img = "../../image/reserve_complete.png";
                  // show = "none";
                  // height = 307;
                  leftShow = "none";
                  rightTitle = "查看订单";
                } else if (res.data.info[i].status == 6) {
                  statusTitle = "已过期";
                  img = "../../image/reserve_cancel.png";
                  // show = "none";
                  // height = 307;
                  leftShow = "none";
                  rightTitle = "删除";
                } else if (res.data.info[i].status == 8) {
                  statusTitle = "预约中";
                  img = "../../image/reserve_reserving.png";
                }
              }
              
              var temp = new model(
                res.data.info[i].addtime,
                img,
                statusTitle,
                getApp().globalData.WEB_URL + res.data.info[i].pic_url,
                res.data.info[i].title,
                res.data.info[i].prov + res.data.info[i].city + res.data.info[i].dist,
                res.data.info[i].status,
                res.data.info[i].goods_id,
                show,
                height,
                leftShow,
                leftTitle,
                rightTitle,
                rightShow,
                res.data.info[i].reservation_number,
                right,
                i
              )
              tempAry.push(temp)
              dataAry = tempAry;
            }

            that.setData({
              list: tempAry
            })
          } else {

          }

        }, function () {
          wx.hideNavigationBarLoading()
          wx.stopPullDownRefresh()
          wx.showToast({
            title: '加载数据失败',
          })
        })

    }else{
      wx.navigateTo({
        url: '../../login/login',
      })
    }
  },

  //cell点击事件
  itemClick: function (event){
    var path = "../car_detail/car_detail?id=" + event.currentTarget.id;
    console.log(path);
    wx.navigateTo({
      url: path,
    })
  },

  //最上面取消按钮点击
  cancelClick: function (){
      this.setData({
          show:"none"
      })
  },

  //cell左侧按钮点击事件
  leftClick: function (){
    wx.navigateTo({
      url: '../credentials/credentials',
    })
  },

  //cell右侧按钮点击事件
  rightClick: function (e) {
    var that = this;
    var model = dataAry[e.currentTarget.id];
    var network = require("../../utils/network.js")

    if (model.rightTitle == "取消预约"){
      //写入参数  
      var params = new Object()
      params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
      params.reservation_number = model.reserve_number;
      console.log(params)
      network.requestLoading(getApp().globalData.API_URL + "/Home/Reservation/delReservation", params, '正在加载数据', function (res) {
        console.log(res)

        wx.hideNavigationBarLoading()
        if (res.status == 1) {
          pageCount = 1;
          that.load();

        } else {
          wx.showToast({
            title: res.msg,
          })
        }
      }, function () {
        wx.hideNavigationBarLoading()
        wx.stopPullDownRefresh()
        wx.showToast({
          title: '加载数据失败',
        })
      })
    } else if (model.rightTitle == "删除"){
      //写入参数  
      var params = new Object()
      params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
      params.reservation_number = model.reserve_number;
      console.log(params)
      network.requestLoading(getApp().globalData.API_URL + "/Home/Reservation/destroyReservation", params, '正在加载数据', function (res) {
        console.log(res)

        wx.hideNavigationBarLoading()
        if (res.status == 1) {
          pageCount = 1;
          that.load();

        } else {
          wx.showToast({
            title: res.msg,
          })
        }
      }, function () {
        wx.hideNavigationBarLoading()
        wx.stopPullDownRefresh()
        wx.showToast({
          title: '加载数据失败',
        })
      })
    } else if (model.rightTitle == "查看订单") {
        wx.navigateTo({
          url: '../order_list/order_list',
        })
    } else if (model.rightTitle == "查看原因") {
      wx.navigateTo({
        url: '../credentials/credentials',
      })
    }
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.load();
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
  
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    pageCount = 1;
    this.load();
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    if (allCount > count) {
      pageCount++;
      this.load();
    } else {
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
      wx.showToast({
        title: '到底了...',
        icon:'none',
        duration:1000
      })
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})