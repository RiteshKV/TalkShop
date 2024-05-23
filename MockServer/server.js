const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();
const port = 3000;

server.use(middlewares);

// Custom route for getting a specific post by postId
server.get('/api/post/:postId', (req, res) => {
  const postId = req.params.postId;
  const db = router.db; // lowdb instance

  const post = db.get('post').find({ postId }).value();

  if (post) {
    res.jsonp({
      status: 'success',
      data: post
    });
  } else {
    res.status(404).jsonp({
      status: 'error',
      message: 'Post not found'
    });
  }
});

server.use(router);
server.listen(port, () => {
  console.log(`JSON Server is running on http://localhost:${port}`);
});
