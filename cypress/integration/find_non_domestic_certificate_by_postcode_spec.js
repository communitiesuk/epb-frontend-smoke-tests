describe('Find non-domestic EPC by postcode (English)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`find_service_en_${process.env.API_STAGE || 'integration'}`))
    cy.contains('Start now').click()
    cy.get('#label-non-domestic').click()
    cy.contains('Continue').click()
    cy.get('input[name=postcode]').type('SW1A 2AA')
    cy.contains('button', 'Find').click()
    cy.contains('DEC').click()
  })

  it('shows the certificate with the expected header', () => {
    cy.get('body').should('contain', 'Display energy certificate (DEC)')
  })
})

describe('Find non-domestic EPC by postcode (Welsh)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`find_service_cy_${process.env.API_STAGE || 'integration'}`))
    cy.contains('Dechreuwch nawr').click()
    cy.get('#label-non-domestic').click()
    cy.contains('Parhau').click()
    cy.get('input[name=postcode]').type('SW1A 2AA')
    cy.contains('button', 'Chwiliwch').click()
    cy.contains('DEC').click()
  })

  it('shows the certificate with the expected header', () => {
    cy.get('body').should('contain', 'Tystysgrif ynni i’w harddangos (DEC)')
  })
})
