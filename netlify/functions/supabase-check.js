
exports.handler = async () => {
  const url = process.env.SUPABASE_URL;
  const key = process.env.SUPABASE_PUBLISHABLE_KEY;

  if (!url || !key) {
    return {
      statusCode: 500,
      body: JSON.stringify({
        status: "error",
        message: "Supabase environment variables are missing"
      })
    };
  }

  try {
    const response = await fetch(
      `${url}/rest/v1/tasks?select=id&limit=1`,
      {
        headers: {
          apikey: key,
          Authorization: `Bearer ${key}`
        }
      }
    );

    if (!response.ok) {
      throw new Error(`Supabase returned HTTP ${response.status}`);
    }

    return {
      statusCode: 200,
      body: JSON.stringify({
        status: "connected",
        message: "Netlify can reach Supabase successfully"
      })
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({
        status: "error",
        message: error.message
      })
    };
  }
};
