const stage = Cypress.env('API_STAGE') || 'production'
const isCrossOrigin = (Cypress.env(`get_service_en_${stage}`) !== Cypress.env(`get_domain_${stage}`))

describe('Find non-domestic certificate by RRN (English)', () => {
    beforeEach(() => {
        cy.visit(Cypress.env(`find_service_en_${Cypress.env('API_STAGE') || 'production'}`))
        cy.contains('Start now').click()
        if (isCrossOrigin) {
            cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                cy.get('#label-non-domestic').click()
                cy.contains('button', 'Continue').click()
                cy.contains('find a certificate by using its certificate number').click()
                cy.get('input[name=reference_number]').type('0060-8260-7119-7386-8570')
                cy.contains('button', 'Find').click()
            })
        } else {
            cy.get('#label-non-domestic').click()
            cy.contains('button', 'Continue').click()
            cy.contains('find a certificate by using its certificate number').click()
            cy.get('input[name=reference_number]').type('0060-8260-7119-7386-8570')
            cy.contains('button', 'Find').click()
        }
    })

    it('shows the certificate with the expected header', () => {
        if (isCrossOrigin) {
            cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                cy.get('body').should('contain', 'Display energy certificate (DEC)')
            })
        } else {
            cy.get('body').should('contain', 'Display energy certificate (DEC)')
        }
    })
})

describe('Find non-domestic certificate by RRN (Welsh)', () => {
    beforeEach(() => {
        cy.visit(Cypress.env(`find_service_cy_${Cypress.env('API_STAGE') || 'production'}`))
        cy.contains('Dechrau nawr').click()
        if (isCrossOrigin) {
            cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                cy.get('#label-non-domestic').click()
                cy.contains('Parhau').click()
                cy.contains('chwilio am dystysgrif drwy ddefnyddio’i rhif tystysgrif').click()
                cy.get('input[name=reference_number]').type('0060-8260-7119-7386-8570')
                cy.contains('button', 'Chwiliwch').click()
            })
        } else {
            cy.get('#label-non-domestic').click()
            cy.contains('Parhau').click()
            cy.contains('chwilio am dystysgrif drwy ddefnyddio’i rhif tystysgrif').click()
            cy.get('input[name=reference_number]').type('0060-8260-7119-7386-8570')
            cy.contains('button', 'Chwiliwch').click()
        }
    })

    it('shows the certificate with the expected header', () => {
        if (isCrossOrigin) {
            cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                cy.get('body').should('contain', 'Tystysgrif ynni i’w harddangos (DEC)')
            })
        } else {
            cy.get('body').should('contain', 'Tystysgrif ynni i’w harddangos (DEC)')
        }
    })
})
