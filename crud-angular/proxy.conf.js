const PROX_CONFIG = [
  {
    context: ['/api'],
    target: 'http://localhost:8080',
    secure: false,
    logLevel: 'debug',
    changeOrigin: true
  }
];

module.exports = PROX_CONFIG;
