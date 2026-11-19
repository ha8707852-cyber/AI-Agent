
exports.handler = async (event) => {
  if (event.httpMethod !== "POST") {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: "POST method required" })
    };
  }

  try {
    const { title, description, assigned_agent } =
      JSON.parse(event.body || "{}");

    const allowedAgents = [
      "Manager",
      "Customer Service",
      "Marketing",
      "IT Coding",
      "Operations"
    ];

    if (!title || !allowedAgents.includes(assigned_agent)) {
      return {
        statusCode: 400,
        body: JSON.stringify({
          error: "A title and valid assigned_agent are required"
        })
      };
    }

    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_PUBLISHABLE_KEY;

    const response = await fetch(
      `${url}/rest/v1/tasks`,
      {
        method: "POST",
        headers: {
          apikey: key,
          Authorization: `Bearer ${key}`,
          "Content-Type": "application/json",
          Prefer: "return=representation"
        },
        body: JSON.stringify({
          title,
          description: description || "",
          assigned_agent,
          status: "pending"
        })
      }
    );

    const result = await response.json();

    if (!response.ok) {
      return {
        statusCode: response.status,
        body: JSON.stringify({ error: result.message || "Database error" })
      };
    }

    return {
      statusCode: 201,
      body: JSON.stringify({
        success: true,
        task: result[0]
      })
    };

  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};
