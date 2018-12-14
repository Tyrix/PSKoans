using module PSKoans

Describe 'Get-PSKoanLocation' {

    Context '$script:LibraryFolder is defined' {
        BeforeAll {
            $TestLocation = 'TestDrive:/PSKoans'
            Set-PSKoanLocation -Path $TestLocation
        }

        It 'should return the stored location' {
            Get-PSKoanLocation | Should -Be $TestLocation -Because 'it was set to this location previously'
        }
    }

    Context '$script:LibraryFolder is not defined' {
        BeforeAll {
            InModuleScope 'PSKoans' {
                $LocationHolder = $script:LibraryFolder
                Remove-Variable -Scope Script -Name 'LibraryFolder'
            }
        }

        It 'should throw an error when called' {
            { Get-PSKoanLocation } | Should -Throw -ExpectedMessage 'PSKoans folder location has not been defined'
        }

        AfterAll {
            InModuleScope 'PSKoans' {
                $script:LibraryFolder = $LocationHolder
            }
        }
    }
}