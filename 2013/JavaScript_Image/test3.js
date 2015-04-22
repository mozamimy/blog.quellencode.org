var date1 = new Date();
var date2 = Date();

[date1, date2].forEach(function(obj) {
  console.log("" + obj.toString() + " : " + typeof obj);
});

/*
 * outputs
 * Fri Mar 01 2013 14:49:24 GMT+0900 (JST) : object
 * Fri Mar 01 2013 14:49:24 GMT+0900 (JST) : string
 */
