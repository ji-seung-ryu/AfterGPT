import SwiftUI

struct OnboardingView: View {
    var onboardingData: Onboarding
    @AppStorage("onboard") var onboard: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                
                
                Spacer()
                
                /*
                 Image("\(self.onboardingData.image)")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .clipShape(RoundedRectangle(cornerRadius: 10))
                 .padding(20)*/
                
                Text("\(self.onboardingData.titleText)")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: geometry.size.width, height: 20, alignment: .center)
                    .font(.title)
                    .multilineTextAlignment(.center)
                                    
                Text("\(self.onboardingData.descriptionText)")
                    .fixedSize(horizontal: false, vertical: true)      .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .font(.system(size: 16))
                    .frame(width: geometry.size.width, height: 50, alignment: .center)
                    .multilineTextAlignment(.center)
            
                if self.onboardingData.showButton ?? false {
                    VStack {
                        
                        Button(action: {
                            onboard = true
                        }) {
                            HStack {
                                Text("지금 시작하기")
                            }.frame(width: geometry.size.width - 200, height: 40)
                                .foregroundColor(Color(.white))
                                .background(Color(UIColor.blue))
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                    }
                    Spacer()
                } else {
                    Spacer()
                    
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingData: Onboarding.sampleData[0])
    }
}
