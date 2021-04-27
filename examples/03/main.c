#define export __attribute__((visibility("default")))

#define import_module(name) __attribute__((import_module(#name)))
#define import_name(name) __attribute__((import_name(#name)))
#define export_name(name) __attribute__((export_name(#name)))

import_module(cat) import_name(eatFood) void cat_give_food();
import_module(dog) import_name(eatFood) void dog_give_food();

export export_name(feedAnimals) void run() {
  cat_give_food();
  dog_give_food();
}
