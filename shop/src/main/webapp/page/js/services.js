angular.module('starter.services', [])

.factory('goodsService', function($http, $q) {
   return {
     getGoods: function() {
       var deferred = $q.defer();
       $http.get('../goods/').success(function(data) {
          console.log('success');
          deferred.resolve(data);
       }).error(function(){
          console.log('error');
          deferred.reject();
       });
       return deferred.promise;
     }
   }
})

.factory('Chats', function() {
  // Might use a resource here that returns a JSON array

  // Some fake testing data
  var chats = [{
    id: 0,
    name: 'Ben Sparrow',
    lastText: 'You on your way?',
    face: 'img/ben.png'
  }, {
    id: 1,
    name: 'Max Lynx',
    lastText: 'Hey, it\'s me',
    face: 'img/max.png'
  }, {
    id: 2,
    name: 'Adam Bradleyson',
    lastText: 'I should buy a boat',
    face: 'img/adam.jpg'
  }, {
    id: 3,
    name: 'Perry Governor',
    lastText: 'Look at my mukluks!',
    face: 'img/perry.png'
  }, {
    id: 4,
    name: 'Mike Harrington',
    lastText: 'This is wicked good ice cream.',
    face: 'img/mike.png'
  }];

  return {
    all: function() {
      return chats;
    },
    remove: function(chat) {
      chats.splice(chats.indexOf(chat), 1);
    },
    get: function(chatId) {
      for (var i = 0; i < chats.length; i++) {
        if (chats[i].id === parseInt(chatId)) {
          return chats[i];
        }
      }
      return null;
    }
  };
})

.factory('Goods', ['$http', function($http) {
/*	var goods = function() {
		return $http({
			method:'GET',
			url:"../json/goods.json"
		})
	}*/
    var goods = [{
    	id: 0,
        name: '商品名称0',
        specifications: 'S',
        price: '222',
        num: '1',
        face: 'img/mike.png'
    }, {
    	id: 1,
        name: '商品名称1',
        specifications: 'M',
        price: '222',
        num: '1',
        face: 'img/mike.png'
    }, {
    	id: 2,
        name: '商品名称2',
        specifications: 'M',
        price: '222',
        num: '1',
        face: 'img/mike.png'
    }, {
    	id: 3,
        name: '商品名称3',
        specifications: 'M',
        price: '222',
        num: '1',
        face: 'img/mike.png'
    }, {
    	id: 4,
        name: '商品名称4',
        specifications: 'M',
        price: '222',
        num: '1',
        face: 'img/mike.png'
    }];
	  
	return {
	    all: function() {
	    	console.log(goods);
	        return goods;
        },
        remove: function(good) {
        	console.log(good);
        	goods.splice(goods.indexOf(good), 1);
        }
	}
}])

.factory('GoodsAttr', ['$rootScope', '$http', function($rootScope, $http) {
    var attrs = [{
    	id: 0,
        name: '商品名称0',
    }, {
    	id: 1,
        name: '商品名称1',
    }, {
    	id: 2,
        name: '商品名称2',
    }, {
    	id: 3,
        name: '商品名称3',
    }, {
    	id: 4,
        name: '商品名称4',
    }];
	  
	return {
	    all: function() {
	        return attrs;
        }
	}
}])

