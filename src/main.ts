import { User } from './model/user';

Sandbox.define('/', 'GET', function(req, res) {
  return res.json('Hello.');
});

Sandbox.define('/users', 'GET', function(req, res) {
  const users = [];
  users.push(new User('Peter Parker', '20'));
  users.push(new User('Clark Ken', '30'));
  return res.json(users);
});

