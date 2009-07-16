#! ruby -Ku

$blogID = 'your-blog-id'
$userID = 'your-user-id'
$label_url = "http://www.blogger.com/feeds/#{$userID}/blogs/#{$blogID}?alt=json-in-script&callback=listLabels"
