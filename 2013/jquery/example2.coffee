# nameというidを持つ名前入力用のテキストボックスがあるとする

name_text_box = $("#name")
name_content = $name.val()

# 以下テキストボックスに対する処理
name_text_box.on "click", ->
  alert name_content
  # :
  # :
