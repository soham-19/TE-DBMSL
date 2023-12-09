show dbs
use Asg10

// 1. Create a collection named books.
db.createCollection('Books')

// 2. Insert 5 records with field TITLE,DESCRIPTION, BY, URL, TAGS AND LIKES

db.Books.insertMany(
    [
        {
            title: 'book 1',
            description : 'description 1',
            by : 'author 1',
            url : 'url 1',
            tags : ['tag1.1', 'tag1.2'],
            likes : 197
        },
        {
            title: 'book 2',
            description : 'description 2',
            by : 'author 2',
            url : 'url 2',
            tags : ['tag2.1', 'tag2.2'],
            likes : 997
        },
        {
            title: 'book 3',
            description : 'description 3',
            by : 'author 3',
            url : 'url 3',
            tags : ['tag3.1', 'tag3.2'],
            likes : 397
        },
        {
            title: 'book 4',
            description : 'description 4',
            by : 'author 4',
            url : 'url 4',
            tags : ['tag4.1', 'tag4.2'],
            likes : 17
        },
        {
            title: 'book 5',
            description : 'description 5',
            by : 'author 5',
            url : 'url 5',
            tags : ['tag5.1', 'tag5.2'],
            likes : 1970
        }
    ]
)

// 3. Insert 1 more document in collection with additional field of
// user name and comments.

db.Books.insertOne(
    {
        title: 'mongodb',
        description : 'best seller book',
        by : 'john',
        url : 'mongodb.com',
        tags: ['mongosh', 'nosqldb'],
        likes: 1200,
        user: ['soham', 'adam'],
        comments: [['nice', 'helpful'],['must buy']]
    }
)

// 4. Display all the documents whose title is 'mongodb',
db.Books.find({title:'mongodb'})

// 5. Display all the documents written by 'john' or whose title is 'mongodb'
db.Books.find( { $or:[ {title:'book 1'}, {by:'john'} ] } )

// 5. Display all the documents written by 'john' and whose title is 'mongodb'

db.Books.find( { $and:[ {title:'mongodb'}, {by:'john'} ]} )

// Display all the documents whose like is greater than 100
db.Books.find( {likes:{$gt:100}} )

// 8. Display all the documents whose like is greater than 100 and whose title is either 
// 'mongodb' or written by 'john'.
db.Books.find( {$and:[ {likes: {$gt:100}}, {$or:[ {title: 'book 1'}, {by: 'john'}]} ]} )

// 9. Update the title of 'mongodb' document to 'mongodb overview'
db.Books.updateOne(
    {title:'mongodb'},
    {$set:{title:'mongodb-edition 2'}}
)

// 10. Delete the document titled 'nosql overview.
db.Books.deleteOne({title: 'book 3'})

// 11. Display exactly two documents written by 'john'.
db.Books.find({by:'john'}).limit(2)

// 13. Display all the books in sorted fashion (ascending by title):
db.Books.find().sort({title:1})

// 14. Insert a document using save method
var docToSave = {
    title: 'last',
    description:'lasttt',
    by: "me",
    url: 'last.com',
    likes: 3492,
    tags : ['lastdoc']
}