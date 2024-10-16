import fetch from 'node-fetch';
import { expect } from 'chai';
import app from '../app.js';

describe('Test Node.js App', function() {
  let server;
  let port;

  // Start the server on a random port
  before((done) => {
    port = Math.floor(Math.random() * 1000) + 3000; // Random port between 3000 and 4000
    server = app.listen(port, () => done());
  });

  // Close the server after tests
  after((done) => {
    server.close(done);
  });

  it('should return Hello, World! on GET /', async function() {
    const response = await fetch(`http://localhost:${port}/`);
    const text = await response.text();

    expect(response.status).to.equal(200);
    expect(text).to.equal('Hello, World!');
  });
});
