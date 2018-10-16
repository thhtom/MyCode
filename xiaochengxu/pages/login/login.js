// pages/login/login.js
var is_time = false;
var is_check = false;

Page({

  /**
   * 页面的初始数据
   */
  data: {
    getmsg: "验证码",
    u_phone:"",
    u_code:"",
    checkboxItems: [
      { name: "check", checked: false }
    ],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    


  },

  check_agreement:function(){
    wx.navigateTo({
      url: '../web/web?url=' + "https://www.rujcar.com/zucexieyiApp.html"
    })

  },

 checkboxChange: function (e) {
    var checked = e.detail.value;
    var changed = {}
    if (checked =="check"){
      is_check = true
    }else{
      is_check = false
    }
    changed['checkboxItems[0].checked']= is_check;
    console.log(is_check)
    this.setData(changed)

    
   
  },




  //获取用户输入的用户名
  phone: function (e) {
    this.setData({
      u_phone: e.detail.value
    })
  },
  code: function (e) {
    this.setData({
      u_code: e.detail.value
    })
  },



  get_code: function () {
    var that = this
      
    var PHONE_NUMBER_REG =/^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;//手机正则式
    if (!PHONE_NUMBER_REG.test(that.data.u_phone)) { //验证手机号
      wx.showToast({
        title: '手机号码有误！',
        icon: 'none',
        duration: 1500
      })
    }else{
      var network = require("../../utils/network.js")
      //写入参数  
      var params = new Object()
      params.mobile = that.data.u_phone;
      network.requestLoading(getApp().globalData.API_URL + "/Home/Register/short_message_send", params,
       '获取中...', function (res) {
        if (res.status == 1) {
          if (!is_time) {
            var time = 60
            var inter = setInterval(function () {
              is_time = true
              that.setData({
                getmsg: time + "  秒",
              })
              time--
              if (time < 0) {
                clearInterval(inter)
                that.setData({
                  getmsg: "重新发送",
                })
                is_time = false;
              }
            }, 1000)

          }
          wx.showToast({
            title: '短信发送成功，请注意查收！',
            icon: 'none',
            duration: 1000
          })
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
  },

  login:function(){
    var that = this
    var PHONE_NUMBER_REG = /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;//手机正则式
    if (!PHONE_NUMBER_REG.test(that.data.u_phone)) { //验证手机号
      wx.showToast({
        title: '手机号码有误！',
        icon: 'none',
        duration: 1000
      })
    }else{
      if (that.data.u_code.length < 1) { //验证手机号
        wx.showToast({
          title: '请输入验证码',
          icon: 'none',
          duration: 1000
        })
      }else{
        if (!is_check) {
          wx.showToast({
            title: '请勾选注册协议',
            icon: 'none',
            duration: 1000
          })
        }else{
          var network = require("../../utils/network.js")
          //写入参数  
          var params = new Object()
          params.mobile = that.data.u_phone;
          params.sms_code = that.data.u_code;
          network.requestLoading(getApp().globalData.API_URL + "/Home/Register/login", params,
            '登录中...', function (res) {
              if (res.status == 1) {
                console.log("---------")
                wx.setStorageSync(getApp().globalData.USER_ID, res.data.user_id);
                wx.setStorageSync(getApp().globalData.TOKEN, res.data.token);
                wx.setStorageSync(getApp().globalData.NICK_NAME, res.data.nick_name);
                wx.setStorageSync(getApp().globalData.AUTHENT, res.data.is_authentication);
                wx.setStorageSync(getApp().globalData.HEADER, res.data.user_header);
                wx.setStorageSync(getApp().globalData.SEX, res.data.sex);
                wx.setStorageSync(getApp().globalData.PHONE, res.data.mobile);
                console.log(wx.getStorageSync(getApp().globalData.NICK_NAME))
                console.log("=============")
                wx.switchTab({
                  url: '../home/home'
                })
                that.onUnload();
              } else {
                wx.showToast({
                  title: res.msg,
                  icon: 'none',
                  duration: 1000
                })
              }
            }, function () {
              wx.showToast({
                title: '登录失败',
              })
            })
        }
      }
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