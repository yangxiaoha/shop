// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic', 'starter.controllers', 'starter.services'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider) {

  // Ionic uses AngularUI Router which uses the concept of states
  // Learn more here: https://github.com/angular-ui/ui-router
  // Set up the various states which the app can be in.
  // Each state's controller can be found in controllers.js
  $stateProvider

  // setup an abstract state for the tabs directive
  .state('tab', {
    url: '/tab',
    abstract: true,
    templateUrl: 'templates/tabs.html'
  })
  
  .state('tabCart', {
    url: '/tabCart',
    abstract: true,
    templateUrl: 'templates/tabs-cart.html'
  })
  
  .state('tabOrder', {
    url: '/tabOrder',
    abstract: true,
    templateUrl: 'templates/tabs-order.html'
  })

  // Each tab has its own nav history stack:

  .state('tab.dash', {
    url: '/dash',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-dash.html',
        controller: 'DashCtrl'
      }
    }
  })

  .state('tabOrder.order', {
    url: '/order',
    views: {
      'tab-order': {
        templateUrl: 'templates/tab-order.html',
      }
    }
  })
  
  .state('tab.chat-detail', {
    url: '/chats/:chatId',
    views: {
      'tab-chats': {
        templateUrl: 'templates/chat-detail.html',
        controller: 'ChatDetailCtrl'
      }
    }
  })

  .state('tab.member', {
    url: '/member',
    views: {
      'tab-member': {
        templateUrl: 'templates/tab-member.html',
      }
    }
  })
  
  .state('tab.test', {
    url: '/test',
    views: {
      'tab-member': {
        templateUrl: 'templates/test.html',
      }
    }
  })
  
  //公告
  .state('tab.notice', {
    url: '/notice',
    views: {
      'tab-dash': {
        templateUrl: 'templates/notice.html',
      }
    }
  })
  
  //商品类别
  .state('tab.commodity-category', {
    url: '/category',
    views: {
      'tab-dash': {
        templateUrl: 'templates/commodity-category.html',
      }
    }
  })
  
  //商品详情
  .state('tabCart.product-details', {
    url: '/details',
    views: {
      'product-details': {
        templateUrl: 'templates/product-details.html',
      }
    }
  })
  
  //购物车
  .state('cart', {
    url: '/cart',
    templateUrl: 'templates/shopping-cart.html',
  })
  
  //结算
  .state('settlement', {
    url: '/settlement',
    templateUrl: 'templates/settlement.html',
  })

  //支付
  .state('pay', {
    url: '/pay',
    templateUrl: 'templates/order-pay.html',
  })
  
  //提现
  .state('withdrawals', {
    url: '/withdrawals',
    templateUrl: 'templates/member-withdrawals.html',
  })
  
  //代言人
  .state('spokesman', {
    url: '/spokesman',
    templateUrl: 'templates/member-search.html',
  })
  
  //会员中心下的订单详情
  .state('orderDetail', {
    url: '/orderDetail',
    templateUrl: 'templates/member-order-detail.html',
  })
  
  //会员信息设置
  .state('memberInfo', {
    url: '/memberInfo',
    templateUrl: 'templates/member-info-edit.html',
  });
  
  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/tab/dash');

});
