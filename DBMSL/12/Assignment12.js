db.orders.insertMany(
    [
        {
            id: 'A1',
            amount: 400,
            status: 'P'
        },
        {
            id: 'B1',
            amount: 300,
            status: 'D'
        },
        {
            id: 'A1',
            amount: 200,
            status: 'F'
        },
        {
            id: 'C1',
            amount: 200,
            status: 'F'
        },
        {
            id: 'B1',
            amount: 700,
            status: 'P'
        },
        {
            id: 'B1',
            amount: 800,
            status: 'P'
        }
    ]
)

// Find the sum of the amount of each customer whose status is "P"
var mapFunction = function () {
    if (this.status === 'P') {
        emit(this.id, this.amount);
    }
};

var reduceFunction = function (custId, amounts) {
    var sum = 0;
    for (var i = 0; i < amounts.length; i++) {
        sum += amounts[i];
    }
    return sum;
};

db.orders.mapReduce(mapFunction, reduceFunction, { out: 'query1' })
db.query1.find();

// 3.Find the minimum amount of each customer:

var mapFunction = function () {
    emit(this.id, this.amount);
};

var reduceFunction = function (cusID, amounts) {
    var ans = Infinity;
    for (var i = 0; i < amounts.length; i++) {
        if (amounts[i] < ans)
            ans = amounts[i];
    }
    return ans;
}

db.orders.mapReduce(mapFunction, reduceFunction, { out: 'query3' })
db.query3.find();

// 4. Find the maximum amount of each customer whose status is "F":

var mapFunction = function () {
    if (this.status === 'F') {
        emit(this.id, this.amount);
    }
}

var reduceFunction = function (cusID, amounts) {
    var max = -1;
    for (var i = 0; i < amounts.length; i++) {
        if (max < amounts[i]) {
            max = amounts[i];
        }
    }
    return max;
}

db.orders.mapReduce(mapFunction, reduceFunction, { out: 'query4' })
db.query4.find();

// 2. Find the average amount of each customer:

var mapFunction = function() {
    emit(this.id, {count:1, total:this.amount });
}

var reduceFunction = function(cust, values) {
    var result = {count: 0, total: 0};
    for(var i=0; i<values.length; i++) {
        result.count++;
        result.total += values[i].total;
    }
    return result;
}

var finalizeFunction = function(cust,result) {
    result.avg = result.total / result.count;
    return result;    
}

db.orders.mapReduce(mapFunction, reduceFunction, {out:'query2', finalize: finalizeFunction});
db.query2.find();