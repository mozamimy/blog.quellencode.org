var array1 = new Array(1, 2, 3);
var array2 = Array(4, 5, 6);
var array3 = [7, 8, 9];

[array1, array2, array3].forEach(function(obj) {
  console.log("" + obj.toString() + " : " + typeof obj);
});

/*
 * outputs
 * 1,2,3 : object
 * 4,5,6 : object
 * 7,8,9 : object
 */
