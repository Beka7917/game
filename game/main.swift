//
//  main.swift
//  game
//
//  Created by Бектур Кадыркулов on 27/2/23.
//

import Foundation



let symbols = (
    empty:"" ,
    player1: "X",
    player2: "O"

)
var field = [[String]]()
print("Добро пожаловать в игру крестики нолики")

while true{
    
    let playerName = getDataFromUser(descripition:"Введите имя первого игрока")
    guard !playerName.isEmpty else{
        print("Вы ввели неправильно")
        continue
        
     }
    let player2Name = getDataFromUser(descripition:"Введите имя второго игрока")
    guard !player2Name.isEmpty else{
        print("Вы ввели неправильно")
        continue
        
     }
    let fieldSize = getDataFromUser(descripition:"Введите размер поля")
    guard  let fieldSize = Int(fieldSize), fieldSize > 0 else{
        print("Вы ввели неправильно")
        continue
        
     }
    
    
     field = [[String]]()
    for _ in 0..<fieldSize {
        var row = [String]()
        for _ in 0..<fieldSize{
            
            row.append(symbols.empty)
        }
        field.append(row)
        
    }
     var fieldForamtedString = ""
    for row in field {
        fieldForamtedString += " | "
        for cell in row{
          fieldForamtedString += cell + " | "
            
        }
        fieldForamtedString += "\n"
        for _ in 0..<(fieldSize * 2 + 1){
        fieldForamtedString += "-"
        }
        fieldForamtedString += "\n"
    }
    printField()
    while true {
        print("\(playerName) делает ход:")
       let row  = getDataFromUser(descripition: "Введите номер строки")
        guard let row  = Int(row), row > 0, row <= fieldSize else{
            print("неправильно")
            continue
            
        }
        
        let column = getDataFromUser(descripition: "Введите номер столба")
        guard let column = Int(column), column > 0 , column <= fieldSize else{
            print("error")
            continue
        }
        let fieldRow = row - 1
        let fieldColumn = column - 1
        guard  field[fieldRow][fieldColumn] == symbols.empty else{
            print("такой ход уже был")
            continue
        }
        field[fieldRow][fieldColumn] = symbols.player1
        break
    }
 
 printField()
    var winnerSymbol: String?
    while true{
        playerTurn(playerName: playerName, symbol: symbols.player1)
         printField()
        if let symbol = checkPlayerWon() {
            winnerSymbol = symbol
            break
        }
        if checkIfGameOvef(){break}
       
         playerTurn(playerName: player2Name,  symbol: symbols.player2)
         printField()
        if let symbol = checkPlayerWon() {
            winnerSymbol = symbol
            break
        }
        if  checkIfGameOvef(){break}
         
    }
    if winnerSymbol == symbols.player1{
       print("Победил:\(playerName)")
    }else if  winnerSymbol == symbols.player2{
        print("Победил:\(player2Name)")
    }else{
        print("Ничья")
        
    }
    
    let shouldStartNewGame = getDataFromUser(descripition: "Если хотите начать новую игру введите - да")
    if shouldStartNewGame != "да"{
        exit(0)
    }
}
func checkPlayerWon() -> String? {
return checkPlayerWonByRows()

    ?? checkPlayerWonByFirstDiagonal()
    ?? checkPlayerWonBySecondDiagonal()
   
    
}


func checkPlayerWonBySecondDiagonal() -> String? {
    
   
    let fieldsize = field.count
    let lastIndex = fieldsize - 1
    let firstSymbol = field[0][lastIndex]
    guard firstSymbol != symbols.empty else {
    return nil
    }
    var iswin = true
    for i in 0..<fieldsize {
    if field[i][lastIndex - i] != firstSymbol {
    iswin = false
    break
    }
    if iswin {
    return firstSymbol
    }
  
    }
    return nil
    }
func checkPlayerWonByFirstDiagonal() -> String? {
   let fieldsize = field.count
  let firstSymbol = field[0][0]
    guard firstSymbol != symbols.empty else {
  return nil
}
  var iswin = true
  for i in 0..<fieldsize {
  if field[i][i] != firstSymbol {
   iswin = false
  break
}
}
  if iswin {
  return firstSymbol
 
}
    return nil
}




func checkPlayerWonByRows() ->String?{
    
    let fieldSize = field.count
    for i in 0..<fieldSize{
        let firstSymbol = field[0][0]
        if firstSymbol == symbols.empty{
            return nil
        }
        var isWin = true
        for j in 0..<fieldSize{
            if field[i][j] != firstSymbol{
                isWin = false
            break
            }
            
        }
        if isWin{
            return firstSymbol
        }
    }
    return nil
}




func checkIfGameOvef()->Bool{
    for row in field{
        
        for cell in row {
            if cell == symbols.empty{
                return false
            }
        }
    }
    
   return true
}


func playerTurn(playerName:String ,symbol:String) {
    let  fieldSize = field.count
    while true {
        print("\(playerName) делает ход:")
       let row  = getDataFromUser(descripition: "Введите номер строки")
        guard let row  = Int(row), row >= 0, row < fieldSize else{
            print("неправильно")
            continue
        }
        let column = getDataFromUser(descripition: "Введите номер столба")
        guard let column = Int(column), column >= 0 , column < fieldSize else{
            print("error")
            continue
        }
      
        field[row][column] = symbol
       
    }
  
}


func printField(){
    let fieldSize = field.count
    var fieldForamtedString = ""
   for row in field {
       fieldForamtedString += "|"
       for cell in row{
         fieldForamtedString += cell + "|"
           
       }
       fieldForamtedString += "\n"
       for _ in 0..<(fieldSize * 2 + 1){
       fieldForamtedString += "-"
       }
       fieldForamtedString += "\n"
   }
   print(fieldForamtedString)
}




        func getDataFromUser(descripition: String) -> String {
            
            print(descripition)
            return readLine() ?? ""
        }

