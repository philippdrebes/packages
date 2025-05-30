#import "../utils/style.typ": 字号, 字体
#import "../utils/double-underline.typ": double-underline
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生英文摘要页
#let bachelor-abstract-en(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  keywords: (),
  outline-title: "ABSTRACT",
  outlined: true,
  anonymous-info-keys: ("author-en", "supervisor-en", "supervisor-ii-en"),
  leading: 1.28em,
  spacing: 1.38em,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title-en: "BNU Thesis Template for Typst",
    author-en: "Zhang San",
    department-en: "XX Department",
    major-en: "XX Major",
    supervisor-en: "Professor Li Si",
  ) + info
  
  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title-en) == str {
    info.title-en = info.title-en.split("\n")
  }
  
  // 3.  内置辅助函数
  let info-value(key, body) = {
    if (not anonymous or (key not in anonymous-info-keys)) {
      body
    }
  }
  
  // 4.  正式渲染
  [
    #pagebreak(weak: true)
    
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(leading: leading, justify: true, spacing: spacing)
    // #show par: set block(spacing: spacing)
    
    // 标记一个不可见的标题用于目录生成
    #invisible-heading(level: 1, outlined: outlined, outline-title)
    
    #align(center)[
      #set text(size: 字号.三号, weight: "bold")
      #set par(leading: 1em)
      
      #v(1em)
      
      #(("",) + info.title-en).sum()
    ]
    
    #v(15pt)
    
    #align(center)[
      #set text(font: 字体.宋体, size: 字号.小三, weight: "bold")
      ABSTRACT
    ]
     
    #body
    
    #v(2em)
    
    #text(font: 字体.宋体, size: 字号.小四, weight: "bold")[#h(2em) KEY WORDS:] #(("",) + keywords.intersperse("; ")).sum()
  ]
  if twoside {
    pagebreak()
    counter(page).update(n => { (n - 1) })
    set page(numbering: none)
    ""
  }
}