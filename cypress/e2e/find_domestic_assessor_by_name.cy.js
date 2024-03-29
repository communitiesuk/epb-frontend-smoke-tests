const stage = Cypress.env('API_STAGE') || 'production'

describe('Find a Domestic Assessor (English)', () => {
  it('shows assessor search results', () => {
    cy.visit(Cypress.env(`get_service_en_${stage}`))
    cy.contains('Start now').click()
    cy.origin(Cypress.env(`get_domain_${stage}`), () => {
      cy.get('#label-domestic').click()
      cy.contains('Continue').click()
      cy.get('#label-domesticRdSap').click()
      cy.contains('Continue').click()
      cy.contains('find an assessor by name').click()
      cy.get('input[name=name]').type('Andrew Parkin')
      cy.contains('Search').click()
      cy.get('body').should(body => {
        const bodyInner = body.text()
        expect(bodyInner).to.match(/results? for the name Andrew Parkin/)
      })
    })
  })
})

describe('Find a Domestic Assessor (Welsh)', () => {
  it('shows assessor search results', () => {
    cy.visit(Cypress.env(`get_service_cy_${stage}`))
    cy.contains('Dechrau nawr').click()
    cy.origin(Cypress.env(`get_domain_${stage}`), () => {
      cy.get('#label-domestic').click()
      cy.contains('Parhau').click()
      cy.get('#label-domesticRdSap').click()
      cy.contains('Parhau').click()
      cy.contains('chwilio am asesydd yn ôl enw').click()
      cy.get('input[name=name]').type('Andrew Parkin')
      cy.contains('button', 'Chwiliwch').click()
      cy.get('body').should(body => {
        const bodyInner = body.text()
        expect(bodyInner).to.match(/canlyniad(au)? ar gyfer yr enw Andrew Parkin/)
      })
    })
  })
})
