resource "local_file" "pet" {
  filename = "/home/evgeniia/Desktop/DoItNow/udemy/learning-quests/terraform_for_the_absolute_beginners_with_labs/terraform-local-file/pets.txt"
  content = "We love pets!"
}
