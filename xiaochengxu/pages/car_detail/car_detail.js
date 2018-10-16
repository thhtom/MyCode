// pages/car_detail/car_detail.js
var imageUtil = require('../../utils/util.js');
var app = getApp()

var maked = 0;
var rental = 0;
var fir_ratio = 0;
var month_ratios = 0;

var car_id = "";
var sub_tag = 0;
var is_click = true;
var that;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    indicatorDots: false,
    vertical: false,
    autoplay: true,
    interval: 2000,
    duration: 500,
    view: {
      Width: 100,
      Height: 100
    },
    title: "",
    fir_stage: "",
    guide_price: "",
    fir_money: "",
    month_money: "",
    fir_ratio: 0,
    month_ratio: 0,
    guide_price_sum: "",
    light_list: [],
    deploy_list: [],
    other_list: [],
    collect_img: '../../image/collect.png',
    subscribe: "立即预约",
    img_url: "",
    baakground:"yellow",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;
    that.setData({
      img_url: getApp().globalData.WEB_URL
    })


    function light(pic_list, word) {
      this.pic_list = pic_list;
      this.word = word;
    }

    function deploy(key, value) {
      this.key = key;
      if (value != undefined) {
        this.value = value;
      } else {
        this.value = "▣标配  -无";
      }
    }
    car_id = options.id;
    var user_id = "";

    try {
      var value = wx.getStorageSync(getApp().globalData.USER_ID)
      if (value.length > 0) {
        user_id = value
      } else {
        user_id = "";
      }
    } catch (e) {
      user_id = "";
    }
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.g_id = car_id;
    params.u_id = user_id;

    console.log(user_id)
    is_click = true;
    network.requestLoading(getApp().globalData.API_URL + "/Home/Goods/getDetail", params, '正在加载数据', function (res) {
      //res就是我们请求接口返回的数据
      var LightEntity = [];
      console.log(res)

     

      if (res.status == 1) {
        for (var i = 0; i < res.data.sheen.length; i++) {
          var Light = new light(getApp().globalData.WEB_URL + res.data.sheen[i].pic_url, res.data.sheen[i].work);
          LightEntity.push(Light);
        }

        var collect_icon = "";

        if (res.data.collection == 0) {
          collect_icon = "../../image/collect.png";
        } else {
          collect_icon = "../../image/collect_yellow.png"
        }
        var sub_list_tag = "立即预约";
        if (res.data.appointment == 0) {
          sub_tag = 0;
          sub_list_tag = "立即预约"
        } else {
          sub_tag = 1;
          sub_list_tag = "查看预约"
        }
        that.setData({
          view: {
            Width: wx.getSystemInfoSync().windowWidth,
            Height: wx.getSystemInfoSync().windowWidth / 3 * 2
          },
          imgUrls: res.data.car_detail.pic_url.map(function (n) {
            return getApp().globalData.WEB_URL + n;
          }),
          title: res.data.car_detail.title,
          guide_price: "官方指导价：" + res.data.car_detail.price_market + "万",
          light_list: LightEntity,
          deploy_list: res.data.car_attr,
          other_list: res.data.recommend,
          collect_img: collect_icon,
          subscribe: sub_list_tag,
        })


        if (res.data.car_detail.status == "8") {
          is_click = false
          that.setData({
            baakground: "#9D9D9D",
            subscribe: "敬请期待"
          })
        }
        
        maked = parseFloat(res.data.car_detail.bare_car);

        rental = parseInt(res.data.car_detail.car_total_price);
        fir_ratio = parseFloat(res.data.car_detail.fir_apply_rate);

        month_ratios = parseInt(res.data.car_detail.total);
        that.countMoneyData(that, maked, rental, fir_ratio, month_ratios)
      } else {
        wx.showToast({
          title: res.msg,
          icon: 'fail',
          duration: 2000
        })
      }


    }, function () {

      wx.showToast({
        title: '加载数据失败',
      })
    })
  },
  sliderfirchange: function (e) {
    that = this;
    fir_ratio = e.detail.value / 100;
    that.countMoneyData(that, maked, rental, parseFloat(e.detail.value / 100), month_ratios)
  },
  slidermonchange: function (e) {
    that = this;
    month_ratios = e.detail.value;
    that.countMoneyData(that, maked, rental, fir_ratio, parseInt(e.detail.value))
  },


  countMoneyData(that, maked, rental, fir_ratio, month_ratio) {
    var fir_money_show = 0;//首付
    var month_money_show = 0;//月供
    var cash_deposit = 0;//保证金
    var service_charge = 0;//服务费

    fir_money_show = maked * fir_ratio;

    var interest = (rental - fir_money_show) * 0.0067 * month_ratio;//利息
    var interest_accrual = rental + interest;//计息总价
    month_money_show = ((interest_accrual - fir_money_show) / month_ratio) + 0.005;//月供
    month_money_show = month_money_show.toFixed(2)
    service_charge = maked * 0.025;//服务费
    cash_deposit = maked * 0.1;//保证金

    that.setData({

      fir_stage: "提车前共支付" + parseInt((fir_money_show + parseFloat(month_money_show) + cash_deposit + service_charge) + 0.5) + "元",
      guide_price_sum: "首付" + fir_money_show +
      "+首月租金" + Math.ceil(month_money_show) +
      "+保证金" + cash_deposit +
      "+服务费" + service_charge,
      fir_money: (fir_money_show / 10000),
      month_money: month_money_show,
      fir_ratio: fir_ratio * 100,
      month_ratio: month_ratio,
    })
  },

  //配置详情
  all_deploy: function () {

    var detail_path = "../all_deploy/all_deploy?id=" + car_id;
    wx.navigateTo({
      url: detail_path
    })

  },

  //车辆item点击事件
  car_detail: function (event) {
    var detail_path = "../car_detail/car_detail?id=" + event.currentTarget.id;
    wx.redirectTo({
      url: detail_path
    })
  },
  //电话咨询
  call: function (event) {
    wx.makePhoneCall({
      phoneNumber: getApp().globalData.SERVICE_TEL,
      success: function () {
        console.log("拨打电话成功！")
      },
      fail: function () {
        console.log("拨打电话失败！")
      }
    })
  },
  collect: function (event) {
    that = this;
    var network = require("../../utils/network.js")
    wx.getStorage({
      key: getApp().globalData.USER_ID,
      success: function (res) {
        console.log(car_id);
        console.log(res.data);
        if (res.data.length > 0) {
          var params = new Object()
          params.goods_id = car_id;
          params.user_id = res.data;
          network.requestLoading(getApp().globalData.API_URL + "/Home/Goods/addFavorite", params, '正在加载数据', function (res) {
            console.log(res)
            if (res.msg == "收藏成功") {
              that.setData({
                collect_img: "../../image/collect_yellow.png"
              })
            } else if (res.msg == "取消成功") {
              that.setData({
                collect_img: "../../image/collect.png"
              })
            }



          }, function () {
            wx.showToast({
              title: '加载数据失败',
            })
          })
        } else {
          wx.navigateTo({
            url: "../login/login"
          })
        }

      },
      fail: function () {
        wx.navigateTo({
          url: "../login/login"
        })
      }
    });
  },
  subscribe: function () {
    if (sub_tag == 0) {
       //跳转立即预约
      if (wx.getStorageSync(getApp().globalData.USER_ID).length > 0) {
        if (is_click){
        wx.navigateTo({
          url: "../look_car/look_car?car_id=" + car_id
        })
        }else{
          wx.showToast({
            title: '即将上市,敬请期待！',
            icon:'none',
            duration:1000
          })
        }


      }else{
        wx.navigateTo({
          url: "../login/login"
        })
      }
     
     


    } else if (sub_tag == 1) {
      //跳转预约列表
      wx.navigateTo({
        url: "../my_reserve/my_reserve"
      })
    }
  },




  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    var that = this;

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