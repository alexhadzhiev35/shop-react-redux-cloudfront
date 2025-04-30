module.exports = async function (context, req) {
  const products = [
    { id: "1", title: "Laptop", description: "Fast laptop", price: 999 },
    { id: "2", title: "Phone", description: "Smartphone", price: 499 },
  ];

  context.res = {
    status: 200,
    body: products,
  };
};
