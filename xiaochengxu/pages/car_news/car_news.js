// pages/car_news/car_news.js
var pageCount = 1;
var allCount = 0;
var count = 0;

Page({

  /**
   * 页面的初始数据
   */
  data: {
    list:[],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.load();
  },

  load (){
    var that = this;
    function news(icon, title, time, id) {
      this.icon = icon
      this.title = title
      this.time = time
      this.id = id
    }

    var network = require("../../utils/network.js")
    var params = new Object()
    params.page = pageCount;
    network.requestLoading(getApp().globalData.API_URL + "/Home/Article/articleList", params, '正在加载数据', function (res) {
      console.log(res);

      wx.stopPullDownRefresh()
      wx.hideNavigationBarLoading()
      

      allCount = res.data.length;
      count = count + res.data.data.length;
      if (res.status == 1) {
        var tempAry = []
        for (var i = 0; i < res.data.data.length; i++) {
          var tempNew = new news(
            getApp().globalData.WEB_URL + res.data.data[i].pic_url,
            res.data.data[i].name,
            res.data.data[i].create_time,
            res.data.data[i].id
          )
          tempAry.push(tempNew)
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
  },


  newsmsg: function (event) {
    var path = "../newsmsg/newsmsg?id=" + event.currentTarget.id;
    wx.navigateTo({
      url: path,
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
        icon:"none",
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