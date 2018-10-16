// pages/my_collection/my_collection.js
var pageCount = 1;
var allCount = 0;
var count = 0;

Page({

  /**
   * 页面的初始数据
   */
  data: {
    list:[],
    show:"none"
  },

  load(){
    var that = this;
    function model(icon,title,price,id,url){
      this.icon = icon;
      this.title = title;
      this.price = price;
      this.id = id;
      this.url = url;
    }

    var network = require("../../utils/network.js")
    var params = new Object()
    params.page = pageCount;
    var user_id = "";
    try {
      user_id = wx.getStorageSync(getApp().globalData.USER_ID);
    } catch (e) {
      user_id = "";
    }
    
    if (user_id.length > 0) {
      params.app_user_id = wx.getStorageSync(getApp().globalData.USER_ID);
      console.log(params);
      network.requestLoading(getApp().globalData.API_URL + "/Home/Goods/getFavorite", params, '正在加载数据', function (res) {
        console.log(res);

        wx.stopPullDownRefresh()
        wx.hideNavigationBarLoading()

        allCount = res.data.count;
        count = count + res.data.optim.length;
        
        if (res.status == 1) {
          var tempAry = [];
         
          for (var i = 0; i < res.data.goods.length; i  ++){
            var temp = new model(
              getApp().globalData.WEB_URL + res.data.goods[i].img,
              res.data.goods[i].title,
              "官方指导价" + parseFloat(res.data.goods[i].price_member)/10000 + "万",
              res.data.goods[i].id,
              "",
            )
            tempAry.push(temp);
          }

          that.setData({
            list:tempAry,
            show:"none"
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

    } else {
      wx.navigateTo({
        url: '../../login/login',
      })
    }
  },

  //cell点击事件
  cellClick: function (event){
    var value = "../car_detail/car_detail?id=" + event.currentTarget.id;
    wx.navigateTo({
      url: value,
    })
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
        icon: "none",
        duration: 1000
      })
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
    wx.showToast({
      title: '哈哈',
    })
  }
})