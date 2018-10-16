// pages/sex/sex.js
var sex = 0

Page({

  /**
   * 页面的初始数据
   */
  data: {
    manColor: "rgb(255,246,248)",
    womanColor: "rgb(243,246,248)",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    sex = 0
      this.setData({
        manColor: "rgb(255,228,1)",
        womanColor: "rgb(243,246,248)",
      })
  },

//男点击事件
  manClick: function () {
    var that = this;
    sex = 0;
    that.setData({
      manColor: "rgb(255,228,1)",
      womanColor: "rgb(243,246,248)",
    })
  },

//女点击事件
  womanClick:function(){
    var that = this;
    sex = 1;
    that.setData({
      womanColor: "rgb(255,228,1)",
      manColor: "rgb(243,246,248)",
    })
  },

//保存点击事件
  saveClick:function(){
    var network = require("../../utils/network.js")
    var params = new Object()
    params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
    params.sex = sex;
    console.log(params)
    network.requestLoading(getApp().globalData.API_URL + "/Home/Pcenter/pictureUpload", params, '正在加载数据', function (res) {

      console.log(res)
      if (res.status == 1) {
        wx.showToast({
          title: res.msg,
          icon: "none",
          duration: 2000
        })
        var value = (sex==0)?"男":"女";
        console.log(value)
        wx.setStorageSync(getApp().globalData.SEX, value);

        setTimeout(function () {
          wx.navigateBack({

          })
        }, 2000)

      } else {

      }

    }, function () {
      wx.showToast({
        title: '加载数据失败',
      })
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
  
  }
})