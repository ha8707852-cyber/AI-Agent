
exports.handler = async () => {
  return {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      status: "online",
      message: "AI Workforce backend is running"
    })
  };
};
