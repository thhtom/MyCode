// pages/home/home.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    indicatorDots: true,
    vertical: false,
    autoplay: true,
    interval: 2000,
    duration: 500,
    list: [],
    view: {
      Width: 100,
      Height: 100
    }
  },




  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;
    function cars(group_name, group_id, isgroup, id, title, price_market,
      fir_apply, tatal, mon_apply, pic_url, status) {
      this.group_name = group_name;
      this.group_id = group_id;
      this.isgroup = isgroup;
      this.id = id;
      this.title = title;
      this.price_market = price_market;
      this.fir_apply = fir_apply;
      this.tatal = tatal;
      this.mon_apply = mon_apply;
      this.pic_url = pic_url;
      this.status = status;
    }
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    network.requestLoading(getApp().globalData.API_URL + "/index.php/home/index/apphome", params, '正在加载数据', function (res) {
    
      if (res.status == 1) {
        var carEntity = []
        for (var i = 0; i < res.data.car.length; i++) {
          var Car_ = new cars(res.data.car[i].group_name, res.data.car[i].group_id, true, "", "", "", "", "", "", "", "");
          carEntity.push(Car_)
          for (var j = 0; j < res.data.car[i].group_list.length; j++) {
            var Car_ = new cars("", "", false,
              res.data.car[i].group_list[j].id,
              res.data.car[i].group_list[j].title,
              res.data.car[i].group_list[j].price_market,
              res.data.car[i].group_list[j].fir_apply,
              res.data.car[i].group_list[j].tatal,
              res.data.car[i].group_list[j].mon_apply,
              getApp().globalData.WEB_URL + res.data.car[i].group_list[j].pic_url,
              res.data.car[i].group_list[j].status)
            carEntity.push(Car_)
          }

        }
        that.setData({
          view: {
            Width: wx.getSystemInfoSync().windowWidth,
            Height: wx.getSystemInfoSync().windowWidth / 2
          },
          imgUrls: res.data.bananer.map(function (n) {
            return getApp().globalData.WEB_URL + n.pic_url;
          }),
          list: carEntity
        })
  
      } else {
        wx.showToast({
          title: res.msg,
          icon: 'fail',
          duration: 2000
        })
      }


    }, function () {
      wx.showToast({
        title: "加载数据失败",
      })

      // wx.showToast({
      //   title: '加载数据失败',
      // })
    })
  },
  //bananer item 点击事件
  item: function () {

    // wx.navigateTo({
    //   url: '../web/web?url="http://www.baidu.com"'
    // })
  },
  //more点击事件
  more: function (event) {
    var detail_path = "../list_car/list_car?id=" + event.currentTarget.id;
    wx.navigateTo({
      url: detail_path
    })
  },
  //车辆item点击事件
  car_detail: function (event) {
    var detail_path = "../car_detail/car_detail?id=" + event.currentTarget.id;
    wx.navigateTo({
      url: detail_path
    })
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
    wx.showNavigationBarLoading()
    this.getRefreshData()
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },

  getRefreshData() {
    var that = this;
    that.setData({
      imgUrls: []
    });
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    network.requestLoading(getApp().globalData.API_URL + "/index.php/home/index/apphome", params, '正在加载数据', function (res) {
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
      that.setData({
        imgUrls: res.data.bananer.map(function (n) {
          return getApp().globalData.WEB_URL + n.pic_url;
        })
      })
    }, 
    function () {
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
      wx.showToast({
        title: '加载数据失败',
      })
    })


  }


})