
exports.handler = async () => {
  const url = process.env.SUPABASE_URL;
  const key = process.env.SUPABASE_PUBLISHABLE_KEY;

  if (!url || !key) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Missing environment variables" })
    };
  }

  try {
    const response = await fetch(
      `${url.replace(/\/$/, "")}/rest/v1/tasks?select=id&limit=1`,
      {
        headers: {
          apikey: key,
          Authorization: `Bearer ${key}`
        }
      }
    );

    const details = await response.text();

    return {
      statusCode: 200,
      body: JSON.stringify({
        http_status: response.status,
        response: details
      })
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};
