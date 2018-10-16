// pages/list_car/list_car.js
var group_id = "";
var page = 1;
var index = 0;
var sum_total = 0;
var list = [];
Page({

  /**
   * 页面的初始数据
   */
  data: {
    img_url: "",
    car_list: [],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;
    list.splice(0, list.length);//清空数组 
    group_id = options.id;
    that.getRefreshData();
    that.setData({
      img_url: getApp().globalData.WEB_URL
    })
  },
  item_click: function (event) {
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
    var that = this;
    page = 1;
    list.splice(0, list.length);//清空数组 
    that.getRefreshData();
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    var that = this;
    if (sum_total > index) {
      page++;
      that.getRefreshData();
    } else {
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
      wx.showToast({
        title: '到底了...',
        icon: 'none',
        duration: 1000
      })
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },

  getRefreshData() {
    var that = this;
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.group_id = group_id;
    params.page = page;
    network.requestLoading(getApp().globalData.API_URL + "/Home/goods/getGoodsByGroup", params, '正在加载数据', function (res) {
      index = res.data.car.length;
      sum_total = res.data.sum;
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
      if (res.status == 1) {
        if (res.data.car.length > 0) {
          list = list.concat(res.data.car)
          that.setData({
            car_list: list,
          });
        }
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
  }
})