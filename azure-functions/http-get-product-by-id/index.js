module.exports = async function (context, req) {
  const productId = req.params.productId;

  const products = [
    { id: "1", title: "Laptop", description: "Fast laptop", price: 999 },
    { id: "2", title: "Phone", description: "Smartphone", price: 499 },
  ];

  const product = products.find((p) => p.id === productId);

  if (product) {
    context.res = {
      status: 200,
      body: product,
    };
  } else {
    context.res = {
      status: 404,
      body: { error: "Product not found" },
    };
  }
};
