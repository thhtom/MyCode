//logs.js

var car_id = "";
var msg = "预约信息不完整！";
var times = "";
var citys = "";
var is_chenk_double = true;
var arrayCity = []
Page({
  data: {
    input_time: "",
    region: "",
    u_phone: "",
    u_name: "",
    u_time: "",
    u_city: "",
    // 普通选择器列表设置,及初始化
    countryList: [],
  },
  bindTimeChange: function (e) {
    times = e.detail.value
    this.setData({
      input_time: e.detail.value
    })
  },
  // bindCityChange: function (arrayCity) {
  //   console.log(arrayCity)
  //   
  //   this.setData({
  //     region: arrayCity.detail.valu
  //   })
  // },

  changeCountry(e) {
    console.log(e)
    citys = arrayCity[e.detail.value]
    this.setData({ region: e.detail.value });
  },

  phone: function (e) {
    this.setData({
      u_phone: e.detail.value
    })
  },
  name: function (e) {
    this.setData({
      u_name: e.detail.value
    })
  },
  time: function (e) {
    this.setData({
      u_time: e.detail.value
    })
  },
  city: function (e) {
    this.setData({
      u_city: e.detail.value
    })
  },

  subscribe: function () {
    var that = this;
    var is_chenk = false;

    if (that.data.u_name.length > 0) {
      var PHONE_NUMBER_REG = /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;//手机正则式
      if (PHONE_NUMBER_REG.test(that.data.u_phone)) { //验证手机号
        if (times.length > 0) {
          if (citys.length > 0) {
            is_chenk = true;
          }
        }
      }
    }

    if (is_chenk && is_chenk_double) {
      is_chenk_double = false
      
      var value = wx.getStorageSync(getApp().globalData.USER_ID);
      var network = require("../../utils/network.js")
      //写入参数  
      var params = new Object()
      params.user_id = value;
      params.reservations_name = that.data.u_name;
      params.reservations_phone = that.data.u_phone;
      params.ctime = times;
      params.address_id = citys;
      params.site = citys;
      params.goods_id = car_id;

      network.requestLoading(getApp().globalData.API_URL + "/Home/Reservation/addReservation", params,
        '获取中...', function (res) {
          console.log(res)
          if (res.status == 1) {
            var time = 2
            wx.showLoading({
              title: "预约中...",
            })
            var inter = setInterval(function () {
              time--
              if (time < 0) {
                clearInterval(inter)
                wx.hideLoading()
                //跳转预约列表
                wx.redirectTo({
                  url: '../my_reserve/my_reserve',
                })
              }
            }, 1000)
          } else {
            is_chenk_double = true
            wx.showToast({
              title: res.msg,
              icon: 'none',
              duration: 1500
            })
          }
        }, function () {
          is_chenk_double = true

        })

    } else {
      wx.showToast({
        title: msg,
        icon: 'none',
        duration: 1500
      })
    }









  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    car_id = options.car_id;
    var that =this;
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.goods_id = car_id;
   
    network.requestLoading(getApp().globalData.API_URL + "/Home/Reservation/getAddress", params,
      '加载中...', 
      function (res) {
        
        if (res.status == 1) {
          for (var i = 0; i < res.data.length;i++){
            arrayCity.push(res.data[i].area)
            
          }
          
          
          console.log(arrayCity)
          that.setData({
            countryList: arrayCity
          })
        } else {
          
        }
      }, function () {
        is_chenk_double = true

      })

 




  },

  onShow: function (){
    is_chenk_double = true
  }
})
