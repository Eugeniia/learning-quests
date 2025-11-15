variable "filename" {
       #default = "/home/evgeniia/Desktop/DoItNow/udemy/learning-quests/terraform_for_the_absolute_beginners_with_labs/terraform-local-file/pets.txt"
       default = [
         "/home/evgeniia/Desktop/DoItNow/udemy/learning-quests/terraform_for_the_absolute_beginners_with_labs/terraform-local-file/pets.txt",
         "/home/evgeniia/Desktop/DoItNow/udemy/learning-quests/terraform_for_the_absolute_beginners_with_labs/terraform-local-file/dogs.txt",
         "/home/evgeniia/Desktop/DoItNow/udemy/learning-quests/terraform_for_the_absolute_beginners_with_labs/terraform-local-file/cats.txt"
       ]
       #type = string
       #type = set(string)
       #description = "the path of the local file"
}
variable "content" {
       default = "We love pets!"
       type = string
       description = "the content of the file"
}
variable "prefix" {
       default = ["Mr", "Mrs", "Sir"]
       type = list
       description = "the prefix to be set"
}
variable "separator" {
       default = "."
}
variable "length" {
       default = 2
       type = number
       description = "length of the pet name"
}
variable file-content {
       type = map
       default = {
           "statement1" = "We love pets!"
           "statement2" = "We love animals!"
       }
}
