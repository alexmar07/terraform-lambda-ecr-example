exports.handler = async (event) => {

    const response = {
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "*",
            "Content-type" : "application/json"
        },
        statusCode: 200,
        body: JSON.stringify({
            message: 'Hello from Lambda!'
        }),
    };

    return response;
};