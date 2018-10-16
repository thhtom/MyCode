// pages/credentials/credentials.js
var img_list = ["", "", "", "", ""];
var params_list = ["positive_card", "reverse_card", "firest_license", "vice_license", "bank_code"]
var is_camera = true


var is_bank_card = "../../image/bank_card.png"
var is_bank_card_width = 340
var is_bank_card_height = 240
var is_bank_card_top = 41
var is_bank_card_show = 'block'

Page({

  /**
   * 页面的初始数据
   */
  data: {
    id_card: "../../image/id_card.png",
    id_card_width: 340,
    id_card_height: 240,
    id_card_top: 41,
    id_card_show: 'block',

    id_card_verso: "../../image/id_card_verso.png",
    id_card_verso_width: 340,
    id_card_verso_height: 240,
    id_card_verso_top: 41,
    id_card_verso_show: 'block',

    driving_licence: "../../image/driving_licence.png",
    driving_licence_width: 340,
    driving_licence_height: 240,
    driving_licence_top: 41,
    driving_licence_show: 'block',

    driving_licence_verso: "../../image/driving_licence_verso.png",
    driving_licence_verso_width: 340,
    driving_licence_verso_height: 240,
    driving_licence_verso_top: 41,
    driving_licence_verso_show: 'block',

    bank_card: "../../image/bank_card.png",
    bank_card_width: 340,
    bank_card_height: 240,
    bank_card_top: 41,
    bank_card_show: 'block',

    show: 'block',
    msg: "完成认证需要核实您的身份信息，请拍摄或上传您的证件",

  },
  id_card: function () {
    //身份证正面
    var that = this
    if (is_camera) {
      wx.chooseImage({
        count: 1, // 默认9  
        sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['camera'], // 可以指定来源是相册还是相机，默认二者都有  
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
          var tempFilePaths = res.tempFilePaths
          img_list.splice(0, 1, tempFilePaths[0])
          console.log(img_list)
          that.setData({
            id_card: tempFilePaths,
            id_card_width: 658,
            id_card_height: 362,
            id_card_top: 0,
            id_card_show: "none"
          })
        }
      })
    }

  },
  id_card_verso: function () {
    //身份证反面
    var that = this
    if (is_camera) {
      wx.chooseImage({
        count: 1, // 默认9  
        sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['camera'], // 可以指定来源是相册还是相机，默认二者都有  
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
          var tempFilePaths = res.tempFilePaths
          img_list.splice(1, 1, tempFilePaths[0])
          console.log(img_list)
          that.setData({
            id_card_verso: tempFilePaths,
            id_card_verso_width: 658,
            id_card_verso_height: 362,
            id_card_verso_top: 0,
            id_card_verso_show: "none"
          })
        }
      })
    }

  },
  driving_licence: function () {
    //驾驶证主页
    var that = this
    if (is_camera) {
      wx.chooseImage({
        count: 1, // 默认9  
        sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['camera'], // 可以指定来源是相册还是相机，默认二者都有  
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
          var tempFilePaths = res.tempFilePaths
          img_list.splice(2, 1, tempFilePaths[0])
          console.log(img_list)
          that.setData({
            driving_licence: tempFilePaths,
            driving_licence_width: 658,
            driving_licence_height: 362,
            driving_licence_top: 0,
            driving_licence_show: "none"
          })
        }
      })

    }
  },
  driving_licence_verso: function () {
    //驾驶证副页
    var that = this
    if (is_camera) {
      wx.chooseImage({
        count: 1, // 默认9  
        sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['camera'], // 可以指定来源是相册还是相机，默认二者都有  
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
          var tempFilePaths = res.tempFilePaths
          img_list.splice(3, 1, tempFilePaths[0])
          console.log(img_list)
          that.setData({

            driving_licence_verso: tempFilePaths,
            driving_licence_verso_width: 658,
            driving_licence_verso_height: 362,
            driving_licence_verso_top: 0,
            driving_licence_verso_show: "none"
          })
        }
      })

    }
  },
  bank_card: function () {
    //银行卡
    var that = this
    if (is_camera) {
      wx.chooseImage({
        count: 1, // 默认9  
        sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['camera'], // 可以指定来源是相册还是相机，默认二者都有  
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
          var tempFilePaths = res.tempFilePaths
          img_list.splice(4, 1, tempFilePaths[0])
          console.log(img_list)
          that.setData({
            bank_card: tempFilePaths,
            bank_card_width: 658,
            bank_card_height: 362,
            bank_card_top: 0,
            bank_card_show: "none"
          })
        }
      })
    }

  },
  sub: function () {
    var that = this;
    var is_sub = true;
    var error_msg = "";
    if (img_list[0].length <= 0) {
      is_sub = false
      error_msg = "请上传身份证正面"
    } else if (img_list[1].length <= 0) {
      is_sub = false
      error_msg = "请上传身份证反面"
    } else if (img_list[2].length <= 0) {
      is_sub = false
      error_msg = "请上传驾驶证主页"
    } else if (img_list[3].length <= 0) {
      is_sub = false
      error_msg = "请上传驾驶证副页"
    }
    console.log(img_list[0].length)
    if (is_sub == true) {
      var successUp = 0; //成功个数
      var failUp = 0; //失败个数
      var length = img_list.length; //总共个数
      var i = 0; //第几个
      wx.showLoading({
        title: '正在上传',
      })
      this.uploadImg(successUp, failUp, i, length); 
    } else {
      wx.showToast({
        title: error_msg,
        icon: 'none',
      })
    }
  },



  uploadImg(successUp, failUp, i, length) {
    var that = this;
    wx.uploadFile({
      url: getApp().globalData.API_URL + '/Home/UserData/uploadOneData',
      filePath: img_list[i],
      name: params_list[i],
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      formData: {
        'user_id': wx.getStorageSync(getApp().globalData.USER_ID),
        'type': "1",
        'access_id': getApp().globalData.ACCESS_ID,
        'device_port': getApp().globalData.DEVICE_PORT,
        'token': wx.getStorageSync(getApp().globalData.TOKEN),
      },
      success: (resp) => {
        successUp++;
        console.log(resp.data)
      },
      fail: (res) => {
        failUp++;
        console.log(res)
      },
      complete: () => {
        i++;
        if (i == length) {
          wx.hideLoading()
          wx.setStorageSync(getApp().globalData.AUTHENT, "1");
          wx.showToast({
            title: '上传成功',
            icon: 'none',
          })
          var time = 2

          var inter = setInterval(function () {
            time--
            if (time < 0) {
              clearInterval(inter)
              wx.switchTab({
                url: '../mine/mine',
              })
            }
          }, 1000)

      
          
        }
        else {  //递归调用uploadDIY函数
          this.uploadImg(successUp, failUp, i, length);
        }
      },
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
    params.type = 2;
    network.requestLoading(getApp().globalData.API_URL + "/Home/UserData/uploadOneData", params, '正在加载数据', function (res) {

      if (res.status == 1) {

        console.log(res)

        wx.setStorageSync(getApp().globalData.AUTHENT, res.data.condition);

        if (res.data.condition == 0) {
          is_camera = true

        } else if (res.data.condition == 1) {
          is_camera = false

          if (res.data.info.bank_code.length > 0) {
            is_bank_card = getApp().globalData.API_URL + res.data.info.bank_code
            is_bank_card_width = 658
            is_bank_card_height = 362
            is_bank_card_top = 0
            is_bank_card_show = "none"
          }



          that.setData({
            id_card: getApp().globalData.API_URL + res.data.info.positive_card,
            id_card_width: 658,
            id_card_height: 362,
            id_card_top: 0,
            id_card_show: "none",

            id_card_verso: getApp().globalData.API_URL + res.data.info.reverse_card,
            id_card_verso_width: 658,
            id_card_verso_height: 362,
            id_card_verso_top: 0,
            id_card_verso_show: "none",

            driving_licence: getApp().globalData.API_URL + res.data.info.firest_license,
            driving_licence_width: 658,
            driving_licence_height: 362,
            driving_licence_top: 0,
            driving_licence_show: "none",

            driving_licence_verso: getApp().globalData.API_URL + res.data.info.vice_license,
            driving_licence_verso_width: 658,
            driving_licence_verso_height: 362,
            driving_licence_verso_top: 0,
            driving_licence_verso_show: "none",


            bank_card: is_bank_card,
            bank_card_width: is_bank_card_width,
            bank_card_height: is_bank_card_height,
            bank_card_top: is_bank_card_top,
            bank_card_show: is_bank_card_show,

            show: 'none',
            msg: "您的证件正在审核中...",

          })
        } else if (res.data.condition == 2) {
          is_camera = true
          that.setData({
            msg: "对不起，您的证件审核未通过，请重新上传",
          })

        } else if (res.data.condition == 3) {
          is_camera = false
          if (res.data.info.bank_code.length > 0) {
            is_bank_card = getApp().globalData.API_URL + res.data.info.bank_code
            is_bank_card_width = 658
            is_bank_card_height = 362
            is_bank_card_top = 0
            is_bank_card_show = "none"
          }
          that.setData({
            id_card: getApp().globalData.API_URL + res.data.info.positive_card,
            id_card_width: 658,
            id_card_height: 362,
            id_card_top: 0,
            id_card_show: "none",

            id_card_verso: getApp().globalData.API_URL + res.data.info.reverse_card,
            id_card_verso_width: 658,
            id_card_verso_height: 362,
            id_card_verso_top: 0,
            id_card_verso_show: "none",

            driving_licence: getApp().globalData.API_URL + res.data.info.firest_license,
            driving_licence_width: 658,
            driving_licence_height: 362,
            driving_licence_top: 0,
            driving_licence_show: "none",

            driving_licence_verso: getApp().globalData.API_URL + res.data.info.vice_license,
            driving_licence_verso_width: 658,
            driving_licence_verso_height: 362,
            driving_licence_verso_top: 0,
            driving_licence_verso_show: "none",


            bank_card: is_bank_card,
            bank_card_width: is_bank_card_width,
            bank_card_height: is_bank_card_height,
            bank_card_top: is_bank_card_top,
            bank_card_show: is_bank_card_show,

            show: 'none',
            msg: "恭喜您的证件审核已通过!",
          })

        }





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