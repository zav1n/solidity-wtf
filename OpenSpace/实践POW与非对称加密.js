const crypto = require("crypto");

// 定义哈希计算函数
function sha256(data) {
  return crypto.createHash("sha256").update(data).digest("hex");
}

// POW 计算函数
function proofOfWork(targetZeros) {
  const nickname = "zaven"; 
  let nonce = 0;
  const target = "0".repeat(targetZeros);
  const startTime = Date.now();

  while (true) {
    const data = nickname + nonce;
    const hash = sha256(data);

    // 检查哈希值是否满足要求
    if (hash.startsWith(target)) {
      const endTime = Date.now();
      const timeSpent = (endTime - startTime) / 1000;
      console.log(`Target: ${targetZeros} zeros`);
      console.log(`Time Spent: ${timeSpent}s`);
      console.log(`Nonce: ${nonce}`);
      console.log(`Data: ${data}`);
      console.log(`Hash: ${hash}`);
      return;
    }

    nonce++;
  }
}

// 运行程序分别找出满足 4 和 5 个零开头的哈希
console.log("Finding hash with 4 leading zeros:");
proofOfWork(4);

console.log("\nFinding hash with 5 leading zeros:");
proofOfWork(5);
