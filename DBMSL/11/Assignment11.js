//1. Find the number of books published by john.
db.Books.aggregate(
    [
        {$match:{BY:'John'}},
        {
            $group:{
                _id:null,
                author:{$first:"$BY"},
                count: {$sum:1}
            }
        }
    ]
)

// Find books which have minimum likes and maximum likes published by john.
db.Books.aggregate(
    [
        {$match:{BY:"John"}},
        {
            $group:{
                _id:null,
                maxLikes: {$max:"$LIKES"}
            }
        }
    ]
)

db.Books.aggregate(
    [
        {$match:{BY:"John"}},
        {
            $group:{
                _id:null,
                minLikes: {$min:"$LIKES"}
            }
        }
    ]
)

// 3. Find the average number of likes for books published by John
db.Books.aggregate(
    [
        {$match:{BY:"John"}},
        {
            $group:{
                _id:null,
                avgLikes : {$avg:"$LIKES"}
            }
        }
    ]
)

//4. Find the first and last book published by john
db.Books.aggregate(
    [
        {$match :{BY:"John"}},
        {
            $group:{
                _id : null,
                firstBook: {$first:"$TITLE"},
                lastBook: {$last:"$TITLE"}
            }
        }
    ]
)

// 5. Create an index on the author name.
db.books.createIndex({ BY: 1 })
// 6. Display the books published by John and check if the index is used:
db.Books.find({ BY: "John" }).explain("executionStats")