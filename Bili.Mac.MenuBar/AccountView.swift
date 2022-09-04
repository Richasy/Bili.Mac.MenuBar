//
//  AccountView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack(alignment:.leading) {
            AccountInformation()
                .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
            List (0..<100){ i in
                        Text("Id:\(i)")
                    }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .frame(width: 400, height: 600, alignment: .center)
    }
}
