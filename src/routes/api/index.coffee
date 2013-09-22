exports.index = (req, res) -> res.render('index', {title: 'index'})
exports.memo = (req, res) -> res.render(
  'memo',
  {title: 'memo', page: req.params.page| 1})
exports.novelIndex = (req, res) -> res.render('novel', {title: 'novel index'})
exports.novel = (req, res) -> res.render('novel', {title: req.params.novel})
exports.about = (req, res) -> res.render('about', {title: about})
