//
//  RecipeDetailView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 22/06/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct RecipeDetailResponse {
  let result: RecipeDetail
}

extension RecipeDetailResponse: Decodable {}

struct RecipeDetail {
  let title: String
  let thumb: String
  let servings: String
  let times: String
  let difficulty: String
  let author: RecipeAuthor
  let desc: String
  let ingredient: [Ingredient]
  let steps: [Step]
  let tags: [String]

  func convertToRecipe() -> Recipe {
    Recipe(title: title, thumb: thumb, times: times, key: "", serving: servings, difficulty: difficulty)
  }
}

extension RecipeDetail: Decodable {
  enum CodingKeys: String, CodingKey {
    case title
    case thumb
    case servings
    case times
    case difficulty
    case author
    case desc
    case ingredient
    case steps
    case tags
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    thumb = try container.decode(String.self, forKey: .thumb)
    servings = try container.decode(String.self, forKey: .servings)
    times = try container.decode(String.self, forKey: .times)
    difficulty = try container.decode(String.self, forKey: .difficulty)
    author = try container.decode(RecipeAuthor.self, forKey: .author)
    desc = try container.decode(String.self, forKey: .desc)
    ingredient = try container.decode([Ingredient].self, forKey: .ingredient)
    let rawSteps = try container.decode([String].self, forKey: .steps)
    steps = zip(rawSteps, rawSteps.indices).map { instruction, index in
      Step(number: index + 1, instruction: instruction)
    }
    tags = try container.decode([String].self, forKey: .tags)
  }
}

struct Step {
  let number: Int
  let instruction: String
}

extension Step: Decodable {}

extension Step: Identifiable {
  var id: String {
    return "\(number)-\(instruction)"
  }
}

extension RecipeDetail {
  static var mock: Self {
    Self(
      title: "Resep Avocado Mocha Brownies Ice Cream Sandwich, Dessert Spesial untuk Buka Bareng Keluarga",
      thumb: "https://www.masakapahariini.com/wp-content/uploads/2021/04/COVER-2-min-780x440.jpg",
      servings: "2 Porsi",
      times: "30mnt",
      difficulty: "Mudah",
      author: .init(
        user: "Dilla",
        datePublished: "April 20, 2021"
      ),
      desc: "Di masa pandemi ini, tentu kita tak bisa leluasa untuk hang out di kafe dan restoran. Namun bukan berarti kita tak bisa menikmati suasana a la kafe, bukan? Salah satu cara yang bisa kamu lakukan untuk mencerahkan hari-hari membosankan di rumah adalah dengan menyajikan menu spesial seperti ice cream sandwich berlapis brownies legit. Apalagi dengan isian es krim rasa avocado dan mocha yang meleleh di mulut, tentu hidangan penutup ini tidak bisa kamu lewatkan begitu saja. Terlebih sebagai dessert untuk berbuka puasa!Siapa yang tidak familiar dengan brownies? Sebagai dessert favorit, tekstur lembutnya sukses membuat ketagihan. Brownies sendiri punya beragam jenis berdasarkan cara memasaknya. Misalnya brownies kukus, brownies panggang, dan brownies bakar. Rasanya pun bervariasi mulai dari cokelat, pandan, hingga stroberi.Kunci dari resep ice cream sandwich ini sendiri terletak dari pembuatan brownies nya. Pastikan ia dipanggang apik dengan komposisi dark chocolate compound, tepung, butter, bubuk kopi, tepung, dan cokelat bubuk yang tepat. Kemudian panggang adonan hingga matang dan simpan di freezer selama kurang lebih 30 menit. Saat kamu ingin menyajikan ice cream sandwich, keluarkan brownies, potong menjadi dua bagian, isi dengan Wall’s Avocado Choco & Mocha, dan tutup dengan potongan brownies satunya. Tentunya, akan semakin nikmat jika kamu menikmatinya dalam kondisi dingin.Untuk kamu penggemar es krim sekaligus brownies, yuk semarakkan bulan Ramadan ini dengan mengombinasikan keduanya menjadi ice cream sandwich yang menggiurkan! Segar dan gurihnya Wall’s Avocado Choco & Mocha berpadu dengan lezatnya brownies membuat ice cream sandwich yang satu ini siap menjadi menu berbuka andalan kamu saat bulan puasa. Apalagi jika proses pembuatannya bersama-sama dengan keluarga tercinta, sungguh seru, bukan?Sudah penasaran untuk mencoba? Yuk, daripada menunggu lama, langsung saja kita buat ice cream sandwich untuk hidangan spesial takjil sore ini! Ingin mencoba kreasi dessert lainnya? Jangan lupa untuk mencoba Oreo Ice Cream Box dan Es Teler Solero.",
      ingredient: [
        .init(quantity: "180", ingredient: "gr gula pasir"),
        .init(quantity: "4", ingredient: "butir telur ayam"),
        .init(quantity: "300", ingredient: "gr dark chocolate compound (DCC)"),
        .init(quantity: "140", ingredient: "gr mentega"),
        .init(quantity: "40", ingredient: "ml minyak goreng"),
        .init(quantity: "200", ingredient: "gr tepung terigu protein sedang"),
        .init(quantity: "40", ingredient: "gr cokelat bubuk"),
        .init(quantity: "10", ingredient: "gr kopi bubuk instan, larutkan dengan air"),
        .init(quantity: "", ingredient: "choco chip"),
        .init(quantity: "", ingredient: "Wall's Avocado Choco & Mocha Ice Cream"),
      ],
      steps: [
        .init(number: 1, instruction: "Lelehkan DCC, mentega, dan minyak goreng dengan cara ditim sampai seluruh coklat leleh. Sisihkan hingga hangat."),
        .init(number: 2, instruction: "Kocok gula pasir dan telur dalam wadah dengan menggunakan mixer (kecepatan sedang) hingga gula benar-benar larut. Masukkan campuran cokelat leleh dan kopi, mixer kembali dengan kecepatan sedang hingga rata dan terlihat mengkilat. "),
        .init(number: 3, instruction: "Masukkan tepung terigu dan cokelat bubuk. Aduk kembali dengan kecepatan rendah sampai tercampur rata.  "),
        .init(number: 4, instruction: "Tuang ke dalam loyang brownies yang sudah dilapisi baking parchment dan diolesi margarin. Panggang selama 35 menit. Simpan brownies di freezer selama 30 menit. "),
        .init(number: 5, instruction: "Potong brownies menjadi 2 bagian, lalu beri Wall’s Avocado Choco & Mocha dan ratakan. Tutup dengan bagian brownies kedua. Simpan dalam freezer selama 6 jam. Beri choco chip di pinggiran ice cream. Sajikan. "),
      ],
      tags: [
        "Appetizer",
        "Buka Puasa",
        "Idul Fitri",
        "Kreasi Es Krim",
        "Manis",
        "Masakan Perkawinan",
        "Tahun Baru",
        "Ulang Tahun",
      ]
    )
  }
}

struct Ingredient {
  let quantity: String
  let ingredient: String

  var asText: String {
    return "\(quantity.trimmingCharacters(in: .whitespaces)) \(ingredient)"
  }
}

extension Ingredient: Decodable {}

extension Ingredient: Identifiable {
  var id: UUID {
    return UUID(uuidString: ingredient) ?? UUID()
  }
}

struct RecipeAuthor {
  let user: String
  let datePublished: String
}

extension RecipeAuthor: Decodable {}

struct RecipeDetailView: View {
  let recipeDetail: RecipeDetail

  let gridItems = Array(repeating: GridItem(.flexible()), count: 2)

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        WebImage(url: URL(string: recipeDetail.thumb))
          .resizable()
          .scaledToFit()
          .frame(width: .infinity)

        VStack(alignment: .leading) {
          Text(recipeDetail.title)
            .fontWeight(.medium)

          RecipeBriefInformationView(recipe: recipeDetail.convertToRecipe())
            .frame(width: .infinity)
            .padding([.vertical], 2)

          Text("Bahan-bahan")
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .font(.system(.title3, design: .rounded))
            .padding(.top, 12)
            .padding(.bottom, 2)

          VStack(alignment: .leading, spacing: 8) {
            ForEach(recipeDetail.ingredient) { ingredient in
              Text(ingredient.asText)
                .foregroundColor(Color(uiColor: .label))
                .font(.footnote)
            }
          }

          Text("Cara membuat")
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .font(.system(.title3, design: .rounded))
            .padding(.top, 12)
            .padding(.bottom, 1)

          VStack(alignment: .leading, spacing: 8) {
            ForEach(recipeDetail.steps) { step in
              HStack(alignment: .top) {
                Text("\(step.number). ")
                  .font(.system(size: 18, weight: .medium))
                  .foregroundColor(.primary)

                Text(step.instruction)
              }
              .foregroundColor(Color(uiColor: .label))
              .font(.footnote)
            }
          }

//          LazyVGrid(columns: gridItems, alignment: .leading, spacing: 8) {
//            ForEach(recipeDetail.ingredient) { ingredient in
//              Text(ingredient.asText)
//                .foregroundColor(Color(uiColor: .label))
//                .font(.footnote)
//            }
//          }
        }
        .padding(.horizontal)
      }
      .navigationTitle(recipeDetail.title)
    }
  }
}

struct RecipeDetailView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeDetailView(recipeDetail: .mock)
  }
}
