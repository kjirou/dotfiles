print('Start loading `~/.mongorc.js`.');


//
// Global Variables
//

var example = function (){
  var blocks = [];

  blocks.push({
    title: 'db.dropDatabase()',
    description: [
      'カレントDBを削除する。',
    ].join('\n')
  });
  blocks.push({
    title: 'db.coll.update()',
    description: [
      'db.coll.update({conds}, {field_name:value});',
      'db.coll.update({conds}, {$set:{field_name:value}});',
      '',
      '- "foo.bar.baz" のように深い階層を直接更新するには $set が必要'
    ].join('\n')
  });
  blocks.push({
    title: 'db.coll.remove()',
    description: [
      'collection を空にする。',
    ].join('\n')
  });

  var insertLeftPadding = function(text, pad){
    return text.replace(/\n/g, '$&' + pad).replace(/^/, pad);
  };

  print('');
  blocks.forEach(function(block){
    print(insertLeftPadding(block.title, '  ') + '\n');
    print(insertLeftPadding(block.description, '    ') + '\n');
  });
};


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
