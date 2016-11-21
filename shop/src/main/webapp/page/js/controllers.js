angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope, $ionicPopup, goodsService) {
   
	goodsService.getGoods().then(function(data) {
		console.log(data);
		$scope.commoditys = data.goodsMsg;
		$scope.types = data.goodsTypeMsg;
	})
	
    $scope.showNotice = function() {
    	$scope.data = {}
    	//自定义弹窗
    	var myPopup = $ionicPopup.show({
    		template: '<p>公告内容</p>',
    		title: '公告',
    		scope: $scope,
    		buttons: [
                { text: '确定', type: 'button-positive' },
            ]
    	})
    } 
 
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
    $scope.chat = Chats.get($stateParams.chatId);
})

.controller('CategoryController', function($scope) {
    $scope.myType = true;
	$scope.mySearch = true;
    $scope.type = function() {
        $scope.myType = !$scope.myType;
    };
    $scope.search = function() {
        $scope.mySearch = !$scope.mySearch;
    };
})

.controller('TabCartCtrl', function($scope, $rootScope, GoodsAttr) {
	$scope.attrs = GoodsAttr.all();
	$scope.myModal = false;
	$scope.num = 0;
    $scope.showModal = function() {
        $scope.myModal = true;
        $rootScope.hideTabs = true;
    };
    $scope.hideModal = function() {
    	$scope.num = 0;
        $scope.myModal = false;
        $rootScope.hideTabs = false;
    };
    $scope.minusNum = function() {
        if($scope.num > 0) {
        	$scope.num--;
        }
    };
    $scope.plusNum = function() {
    	$scope.num++;
    };
})
