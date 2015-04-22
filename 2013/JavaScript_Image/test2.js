var image1 = new Image();
var image2 = Image();
image1.src = "http://example.com/image1";
image2.src = "http://example.com/image2";

[image1, image2].forEach(function(obj) {
  console.log("" + obj.src + " : " + typeof obj);
});

/*
 * outputs
 * http://example.com/image1 : object
 * http://example.com/image2 : object
 */
