import SwiftUI

struct MaterialSegmentControl : View {
    @State private var selectorIndex = 0
    @State private var numbers = [("最新优惠", "latest"),("热门游戏", "hot"),("会员独享", "plus")]

    var body: some View {
        VStack {
            // 2
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0 ..< numbers.count) { index in
                    Text(self.numbers[index].0).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // 3.
            Text("Selected value is: \(numbers[selectorIndex].0)").padding()
        }
    }
}

struct MaterialSegmentControl_Previews: PreviewProvider {
    static var previews: some View {
        MaterialSegmentControl()
    }
}
