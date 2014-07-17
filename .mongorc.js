print('Start loading `~/.mongorc.js`.');


//
// Global Variables
//


//
// Native Object Enhancements
//
// ネイティブオブジェクトのプロパティには補完が効かないので、メソッド名が長いと使い難い
String.prototype.id = function(){ return ObjectId(this.valueOf()); };
//String.prototype.toObjectId = function(){ return ObjectId(this.valueOf()); };


//
// DBCollection Enhancements
//
DBCollection.prototype.findById = function(id){return this.findOne({_id:ObjectId(id)});};
DBCollection.prototype.fbi = function(id){return this.findOne({_id:ObjectId(id)});};

DBCollection.prototype.p = function(){
  return this.find.apply(this, arguments).pretty();
};

// TODO:
// find 時にカレントコレクションを格納するようにしようと思ったが "admin.$cmd" になってしまう。
// getCollectionNames を使って、現在選択中でユーザー定義されたコレクションだけを対象にする。
//var _lastFoundCollection = null;
//var originalFind = DBCollection.prototype.find;
//DBCollection.prototype.find = function(){
//  _lastFoundCollection = this;
//  return originalFind.apply(this, arguments);
//};
//
//var f = function(){
//  return _lastFoundCollection.find.apply(_lastFoundCollection, arguments);
//};


//
// DBQuery Enhancements
//
DBQuery.prototype.p = DBQuery.prototype.pretty;


print('Complete loading `~/.mongorc.js`.');
