# nameというidを持つ名前入力用のテキストボックスがあるとする

$name = $("#name")
name = $name.val()

# 以下テキストボックスに対する処理
$name.on "click", ->
  alert name
  # :
  # :
