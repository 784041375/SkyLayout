# SkyLayout

let a = UIView()

let b = UIScrollView()

a.addSubview(b)

a.left - 5 == b.right + 5

a.left - 5 == b.rightAnchor

a.left - 5 == b

a.left - 5 == b.safeRight + 5

a.left - 5 == b.frameRight

a.height * 2 - 5 == b.width * 5 - 5

a.height * 2 == 5

a.height * 2 == b

a.height * 2 == b.frameWidth

a.left.right.width == b

a.edges == b

a.width.height == 5
