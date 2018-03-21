require 'rails_helper'
feature 'Owner add a photo' do
  scenario 'on perfil' do
    owner = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')

    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: 'proprietario@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Meu perfil'
    click_on 'Editar perfil'

    fill_in 'Confirmação da senha', with: '123456'

    attach_file('Imagem', Rails.root.join('spec', 'support', 'fixtures', 'teste.png'))

    click_on 'Salvar'

    click_on 'Meu perfil'

    #expect(page).to have_xpath("//img[@src='teste.png']")
    expect(page).to have_css("img[src*='teste.png']")
  end
end
