const stage = Cypress.env('API_STAGE') || 'production'

describe('Find a non-domestic assessor (English)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`get_service_en_${Cypress.env('API_STAGE') || 'production'}`))
    cy.contains('Start now').click()
    cy.origin(Cypress.env(`get_domain_${stage}`), () => {
      cy.get('#label-non-domestic').click()
      cy.contains('Continue').click()
    })
  })

  context('when searching by name', () => {
    beforeEach(() => {
      cy.origin(Cypress.env(`get_domain_${stage}`), () => {
        cy.contains('find an assessor by name').click()
        cy.get('input[name=name]').type('Andrew Parkin')
        cy.contains('button', 'Search').click()
      })
    })

    it('shows assessor search results', () => {
      cy.origin(Cypress.env(`get_domain_${stage}`), () => {
        cy.get('body').should(body => {
          const bodyInner = body.text()
          expect(bodyInner).to.match(/results? for the name Andrew Parkin/)
        })
      })
    })
  })
})

describe('Find a non-domestic assessor (Welsh)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`get_service_cy_${Cypress.env('API_STAGE') || 'production'}`))
    cy.contains('Dechrau nawr').click()
    cy.origin(Cypress.env(`get_domain_${stage}`), () => {
      cy.get('#label-non-domestic').click()
      cy.contains('Parhau').click()
    })
  })

  context('when searching for an assessor by name', () => {
    beforeEach(() => {
      cy.origin(Cypress.env(`get_domain_${stage}`), () => {
        cy.contains('chwilio am asesydd yn ôl enw').click()
        cy.get('input[name=name]').type('Andrew Parkin')
        cy.contains('button', 'Chwiliwch').click()
      })
    })

    it('shows assessor search results', () => {
      cy.origin(Cypress.env(`get_domain_${stage}`), () => {
        cy.get('body').should(body => {
          const bodyInner = body.text()
          expect(bodyInner).to.match(/canlyniad(au)? ar gyfer yr enw Andrew Parkin/)
        })
      })
    })
  })
})
