exports.handler = (event, context, callback) => {
callback(null, {statusCode: 200, body: "DevOps Labs!"});
};
export const handler = async () => ({
  statusCode: 200,
  body: JSON.stringify({ message: "Hello, World!" })
});

