// pages/nick_name/nick_name.js
var text = ""

Page({

  /**
   * 页面的初始数据
   */
  data: {
  
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  
  },

  //获取输入框内容
  edit: function (e) {
    text = e.detail.value;
  },

  //保存按钮
  saveClick:function (){
    if (text.length == 0) {
      wx.showToast({
        title: '请输入昵称',
        icon: "none",
        duration: 1500
      })
    } else {
      var network = require("../../utils/network.js")
      var params = new Object()
      params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
      params.nick_name = text;
      console.log(params)
      network.requestLoading(getApp().globalData.API_URL + "/Home/Pcenter/pictureUpload", params, '正在加载数据', function (res) {

        console.log(res)
        if (res.status == 1) {
          wx.showToast({
            title: res.msg,
            icon: "none",
            duration: 2000
          })
          
          wx.setStorageSync(getApp().globalData.NICK_NAME, text);
          text = ""; 

          console.log("======================")

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
    }
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