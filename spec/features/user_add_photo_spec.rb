require 'rails_helper'

feature 'user add photo' do
  scenario 'successfully' do
    #Criação dos dados
    user = User.create!(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '11-987654321')

    #Navegação
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Perfil'
    click_on 'Send photo'
    attach_file('Image', File.join(Rails.root, 'spec/images/image.jpg'))
    click_on 'Upload'

    #Expectativa
    expect(page).to have_css('h1', text: 'Perfil do usuário')
    expect(page).to have_css("img[src*='image.jpg']")

  end
end
