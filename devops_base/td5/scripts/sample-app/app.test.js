const request = require('supertest');
const app = require('./app');
describe('Test the root path', () => {
    test('It should respond to the GET method', async () => {
        const response = await request(app).get('/');

        expect(response.statusCode).toBe(200);
        expect(response.text).toBe('DevOps Labs!');
    });
});

describe('Test the /name/:name path', () => {
    test('It should respond with a personalized greeting', async () => {
        const name = 'Alice';
        const response = await request(app).get(`/name/${name}`);

        expect(response.statusCode).toBe(200);
        expect(response.text).toBe(`Hello, ${name}!`);
    });
});

describe('Test the /:a/:b path', () => {
    test('It should respond with the result', async () => {
        const a = 4;
        const b = 5;
        const response = await request(app).get(`/${a}/${b}`);
        
        expect(response.statusCode).toBe(200);
        expect(response.text).toBe(String("9"));
    });
});